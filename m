From: Mark Lord <lkml@rtr.ca>
Subject: Re: Stardom SATA HSM violation
Date: Thu, 27 Sep 2007 23:52:18 -0400
Message-ID: <46FC7A72.4000301@rtr.ca>
References: <46CFA08E.6090604@arbores.ca>	<6bffcb0e0708261610g10d9c59ck5789fac6feca9f42@mail.gmail.com>	<46DBCB6C.8080206@gmail.com>	<20070905095327.6277d054.akpm@linux-foundation.org>	<46DEE617.4050004@rtr.ca>	<46E0A253.7060803@gmail.com>	<46E154DE.2060602@rtr.ca>	<46FB563A.80108@gmail.com> <20070927193701.6230d77f@the-village.bc.nu> <46FC3D7D.90009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758950AbXI1Dwc@vger.kernel.org>
In-Reply-To: <46FC3D7D.90009@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, Andrew Morton <akpm@linux-foundation.org>, michal.k.k.piotrowski@gmail.com, bryan@arbores.ca, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Alan Cox wrote:
>>> I think there have been enough cases where this draining was necessary.
>>>  IIRC, ata_piix was involved in those cases, right?  If so, can you
>>> please submit a patch which applies this only to affected controllers?
>>> I don't feel too confident about applying this to all SFF controllers.
>> Old IDE does it on all controllers bar a couple. So we have a very good
>> knowledge of what does/doesn't work. The one that needs care in old ide
>> is an ordering issue where a state machine reset done first causes the
>> drain of the I/O to hang.
> 
> Hmmm... So, do we apply draining to all PATA?  Or is ata_piix SATA
> affected too?

ata_piix SATA is definitely affected when a PATA_drive to SATA_host bridge is present.
Possibly other times.

Cheers
