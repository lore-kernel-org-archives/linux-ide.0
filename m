From: Tejun Heo <htejun@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Wed, 08 Aug 2007 23:30:18 +0900
Message-ID: <46B9D37A.4070403@gmail.com>
References: <fa.bsWpbo79BZgHoaIGhEMfTEBxs54@ifi.uio.no>	 <fa.mg6p0itaOQUo/t8deCaYpyqj6Nk@ifi.uio.no>	 <fa.RxWYL8z8KktgL8LGZ/cTB2nI1Yc@ifi.uio.no>	 <fa.AyyCtZ2yLjC5noHPHtmzn4ffhhE@ifi.uio.no>	 <fa.SuAjism+m0z0haqCRVjkc2S978o@ifi.uio.no>	 <fa.QgWcLG2hfRb92g4blN61qYfRjlQ@ifi.uio.no> <46B7AF53.1040307@shaw.ca>	 <46B8140E.3000509@gmail.com>  <1186497925.8780.78.camel@queen.suse.de> <1186514618.5622.9.camel@nx6310> <46B9307D.3000105@gmail.com> <46B9CE79.5030307@rtr.ca> <46B9CFB3.6020402@gmail.com> <46B9D219.6030509@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <46B9D219.6030509@rtr.ca>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Michael Sedkowski <sedmich@gmail.com>, trenn@suse.de, Robert Hancock <hancockr@shaw.ca>, "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Mark Lord wrote:
> Heh.. I haven't instrumented it yet, but I did discover a bit more about
> it:
> 
> The Power-Off_Retract_Count incrmenents *only* when there's data in the
> on-drive write-cache.  So if I haven't written anything significantly large
> before suspending, then it often does NOT increment the retract counter.
> 
> But if I copy a couple of multi-MB files around and then suspend (to RAM),
> the retract count gets incremented.
> 
> So I've now just stuck "hdparm -F /dev/sda" into my suspend script,
> and that cures the problem completely for me.  "-F" does a FLUSH_CACHE,
> and requires a recent copy of hdparm.
> 
> Perhaps libata should also do a FLUSH_CACHE before any STANDBYNOW command,
> prior to entering STR, which is what my script is currently now doing..
> 
> I'll instrument libata and see what the current sequence is.

Hmmmm.. libata should issue FLUSH CACHE on STR too.  sd_suspend() and
sd_shutdown() are pretty similar after all.

-- 
tejun
