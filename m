From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: Libata EH False Alarm (2.6.18-rc2)?
Date: Thu, 24 Aug 2006 14:05:18 -0600
Message-ID: <8202f4270608241305n2e0d3e80q2bd377ae85d841bb@mail.gmail.com>
References: <8202f4270608241242i7a4d2d0anc3f607dad7df0129@mail.gmail.com>
	 <44EE0561.1030007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:48114 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030469AbWHXUFT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Aug 2006 16:05:19 -0400
Received: by py-out-1112.google.com with SMTP id n25so876424pyg
        for <linux-ide@vger.kernel.org>; Thu, 24 Aug 2006 13:05:18 -0700 (PDT)
In-Reply-To: <44EE0561.1030007@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Sil3124. That's the only chipset we use.

Thanks,
Fajun

On 8/24/06, Tejun Heo <htejun@gmail.com> wrote:
> Fajun Chen wrote:
> > Hi Guys,
> >
> > I ran 2.6.18-rc2 with libata patch. I have seen many occurrences of EH
> > traces in dmesg log as show below:
> > ...
> > [30540.003174] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
> > 0x2 frozen
> > [30540.003259] ata1: (irq_stat 0x01100010, PHY RDY changed)
> > [30540.548784] ata1: waiting for device to spin up (8 secs)
> > [30548.721383] ata1: soft resetting port
> > [30548.822362] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > [30548.825201] ata1.00: configured for UDMA/100
> > [30548.825248] ata1: EH complete
> > [repeats]...
> >
> > While at the same time, my testing still proceeded without problem.
> > Are these genuine errors or false alarms?
>
> Do you happen to be using sata_sil on ATI controller?  If so, those
> chipsets don't support hotplug && please use -rc4.  If you're using
> something else, please report what chipset you're using.
>
> --
> tejun
>
