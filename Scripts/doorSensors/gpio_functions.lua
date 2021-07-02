irq_pin = 3
debounceDelay = 250

function init_irq()
    gpio.mode(irq_pin, gpio.INT, gpio.PULLUP)
    gpio.trig(irq_pin, "down", uniq)
end

function uniq()
    gpio.trig(irq_pin, "none")
    tmr.create():alarm(debounceDelay, tmr.ALARM_SINGLE, change_edge)
end

function change_edge()
	next_edge = "down"
	level = gpio.read(irq_pin)
	if level == gpio.LOW then
		next_edge = "up"
	end
	gpio.trig(irq_pin, next_edge, uniq)
	print("edge changed to " .. next_edge)
end

init_irq()