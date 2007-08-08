From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Tue, 07 Aug 2007 22:26:46 -0600
Message-ID: <46B94606.9040003@shaw.ca>
References: <fa.kWUtPRLMmU/fKL6dyOOVKsSM0fg@ifi.uio.no>
 <fa.EbjjD+/NapKvm3jfMLnkxumomC0@ifi.uio.no>
 <fa.dm4O1sGL4RetYq2szbwwJT3cf2c@ifi.uio.no>
 <fa.7tYfpSdE8/lmfK5ulSN+/6TRSbw@ifi.uio.no>
 <fa.R1sVaL6mATofNd18aEZgwlczb8M@ifi.uio.no>
 <fa.Z030SpvZYAHux0f8UtlnJwatsvY@ifi.uio.no> <46B90AE0.2070403@shaw.ca>
 <20070808040607.GA16466@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <20070808040607.GA16466@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Tejun Heo <htejun@gmail.com>, Michael Sedkowski <sedmich@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> On Tue, 07 Aug 2007, Robert Hancock wrote:
>>> You *do* have to worry about it in any box you turn off daily.  Desktop
>>> HDs will croak fast in that scenario, laptop HDs less so, but still too
>>> fast.  A very good laptop HD can last about 20k emergency unloads (this
>>> is a unit that can do about 600k normal unloads in its lifetime).
>>> Desktop and server HDs don't even come close to those numbers, last time
>>> I checked.
>> It only matters on hard drives which actually use load-unload heads. Lots
>> of desktop/server drives (perhaps some laptop ones as well) still use
>> contact start/stop, which doesn't remove the heads from the platters on
> 
> I am not so sure about that.
> 
> Please correct me if I am wrong, but contact stop in an emergency retract
> shakes the head assembly badly as well. It subjects the head assembly to
> higher acceleration than a normal seek, and a nasty impulse at impact with
> the stopper.  And I very much doubt it is nice to the heads to slide into
> the parking zone at high speed and hit the bumper while over it.
> 
> Unless I missed something, I don't why an emergency retract would not be as
> big a problem as an emergency unload.
> 
> Maybe we should hunt down some proper datasheets for drives lacking head
> load/unload technology, and check what they say about emergency unloads...

I did a bit of a look and didn't find any mention of the subject for 
drives using contact start/stop. I did find mention that the unload 
torque needed is quite a bit higher on load/unload systems, so I would 
imagine that having to extract or store that energy for emergency 
unloads would be more of a demanding task and might be a rougher process.

Just judging from the sound, though, hard power-offs on a desktop 
Seagate Barracuda 7200.10, for example, which is contact start/stop, 
don't really sound any different from a commanded standby. On the laptop 
drives I've seen you can really tell the difference.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

