From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Tue, 07 Aug 2007 18:14:24 -0600
Message-ID: <46B90AE0.2070403@shaw.ca>
References: <fa.kWUtPRLMmU/fKL6dyOOVKsSM0fg@ifi.uio.no>
 <fa.EbjjD+/NapKvm3jfMLnkxumomC0@ifi.uio.no>
 <fa.dm4O1sGL4RetYq2szbwwJT3cf2c@ifi.uio.no>
 <fa.7tYfpSdE8/lmfK5ulSN+/6TRSbw@ifi.uio.no>
 <fa.R1sVaL6mATofNd18aEZgwlczb8M@ifi.uio.no>
 <fa.Z030SpvZYAHux0f8UtlnJwatsvY@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <fa.Z030SpvZYAHux0f8UtlnJwatsvY@ifi.uio.no>
Sender: linux-acpi-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Tejun Heo <htejun@gmail.com>, Michael Sedkowski <sedmich@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> On Tue, 07 Aug 2007, Tejun Heo wrote:
>> emergency unload.  Emergency unload does shorten the lifespan of the
>> disk but you don't have to worry too much about it.  Disks are designed
>> to withstand certain number of emergency unloads.
> 
> You *do* have to worry about it in any box you turn off daily.  Desktop HDs
> will croak fast in that scenario, laptop HDs less so, but still too fast.
> 
> A very good laptop HD can last about 20k emergency unloads (this is a unit
> that can do about 600k normal unloads in its lifetime).  Desktop and server
> HDs don't even come close to those numbers, last time I checked.

It only matters on hard drives which actually use load-unload heads. 
Lots of desktop/server drives (perhaps some laptop ones as well) still 
use contact start/stop, which doesn't remove the heads from the platters 
on shutdown but just parks the heads over the landing zone. I don't 
think arbitrary power-offs make too much difference on those drives. 
(However, these generally aren't rated to handle as many start/stop 
cycles, which is why laptop drives generally use load/unload instead.)

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

