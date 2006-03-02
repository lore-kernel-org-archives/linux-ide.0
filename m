From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Date: Wed, 01 Mar 2006 22:06:26 -0500
Message-ID: <44066132.4010205@pobox.com>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	 <4405F471.8000602@rtr.ca>	 <1141254762.11543.10.camel@rousalka.dyndns.org>	 <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>	 <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>	 <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>	 <44065C7C.6090509@pobox.com> <311601c90603011900q7fe21fbx1020e4ba4062dc24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751386AbWCBDGf@vger.kernel.org>
In-Reply-To: <311601c90603011900q7fe21fbx1020e4ba4062dc24@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>, Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>
List-Id: linux-ide@vger.kernel.org

Eric D. Mudama wrote:
> The "failing dmesg" has the plextor connected to sata_nv, and the two
> Maxtor drives connected to sata_sil, if I read it correctly.  They're
> ata5/ata6 ports, mapped as sda/sdb.
> 
> Nicolas' comment in the thread "Re: LibPATA code issues / 2.6.15.4"
> seemed to say it was the same adapter:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114123989405668&w=2

Sounds like un-blacklisting the drive, and adding ATA_FLAG_NO_FUA is the 
way to go...

	Jeff
