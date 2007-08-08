From: Tejun Heo <htejun@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Thu, 09 Aug 2007 01:20:24 +0900
Message-ID: <46B9ED48.1010901@gmail.com>
References: <fa.bsWpbo79BZgHoaIGhEMfTEBxs54@ifi.uio.no>	 <fa.mg6p0itaOQUo/t8deCaYpyqj6Nk@ifi.uio.no>	 <fa.RxWYL8z8KktgL8LGZ/cTB2nI1Yc@ifi.uio.no>	 <fa.AyyCtZ2yLjC5noHPHtmzn4ffhhE@ifi.uio.no>	 <fa.SuAjism+m0z0haqCRVjkc2S978o@ifi.uio.no>	 <fa.QgWcLG2hfRb92g4blN61qYfRjlQ@ifi.uio.no> <46B7AF53.1040307@shaw.ca>	 <46B8140E.3000509@gmail.com>  <1186497925.8780.78.camel@queen.suse.de> <1186514618.5622.9.camel@nx6310> <46B9307D.3000105@gmail.com> <46B9CE79.5030307@rtr.ca> <46B9CFB3.6020402@gmail.com> <46B9D219.6030509@rtr.ca> <46B9DF91.7050709@rtr.ca> <46B9E2C4.7070307@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <46B9E2C4.7070307@rtr.ca>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Michael Sedkowski <sedmich@gmail.com>, trenn@suse.de, Robert Hancock <hancockr@shaw.ca>, "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Mark Lord wrote:
> Further to this, if I have an active-writer running at the time of suspend,
> then even my scripted "sleep 1" is not good enough, as additional writes
> are still happening before/after the flush.
> 
> Now I'll reboot and try it with the "sleep 1" hardcoded inside
> sd_suspend().

Hmmm... queue quiescing might be broken.  Can you verify there's no
command issued between STANDBYNOW1 and suspending?

-- 
tejun
