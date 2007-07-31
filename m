From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 2/4] Expose Power Management Policy option to users
Date: Wed, 01 Aug 2007 03:29:18 +0900
Message-ID: <46AF7F7E.6060300@gmail.com>
References: <20070705194909.337398431@intel.com>	 <20070705130518.135e4e3c.kristen.c.accardi@intel.com>	 <46AE12B6.6090408@garzik.org>  <46AED656.8070407@gmail.com>	 <1185891382.2750.8.camel@laptopd505.fenrus.org>	 <46AF4B05.4010700@gmail.com> <1185898532.2766.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1185898532.2766.2.camel@laptopd505.fenrus.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jeff@garzik.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, edwintorok@gmail.com, axboe@kernel.dk
List-Id: linux-ide@vger.kernel.org

Arjan van de Ven wrote:
>> They were hardware problems.  I don't think any amount of proper
>> implementation can fix them.  I have one DVD RAM somewhere in my pile of
>> hardware which locks up solidly if any link PS mode is used and had a
> 
> and the AHCI ALPM code decides to use power savings on this device? if
> so, please give us the idents so that we can add it to the blacklist as
> the first entry... (or can buy it to check it in detail first)

Yeap, lemme check.

It's "TSSTcorpCD/DVDW SH-S183A" with firmware revision "SB01".  Wanna
check ID capability bits but 'hdparm -I /dev/sr0' is still broken and
it's already past 3 am here.  I'll report back tomorrow.

Thanks.

-- 
tejun
