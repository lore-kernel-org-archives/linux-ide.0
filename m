From: "Eric Mayo" <eric@pozicom.net>
Subject: Re: multiple sata_mv boards with same DevID ?
Date: Tue, 27 Jan 2009 14:48:36 -0500 (EST)
Message-ID: <fb714695cacaed9c18e05a1c06351e77.squirrel@webmail.pozicom.net>
References: <20080731213509.5C8573CF98@mail.pozicom.net>
    <497F3C57.9000006@pobox.com>
Reply-To: eric@pozicom.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx01.pozicom.net ([70.88.103.169]:48000 "EHLO mail.pozicom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbZA0UPL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 15:15:11 -0500
In-Reply-To: <497F3C57.9000006@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi Mark,

I no longer have the card.

~Eric


> eric wrote:
> ..
>>>> We have the HighPoint 1740 SATAII RAID card.  I had to modify the
>>>> sata_mv.c
>>>> (attached) to get it to work with my card.  The interesting bits are
>>>> as
>>>> follows:
>>>>
>>>> /* RocketRAID 1740/174x have different identifiers */
>>>>
>>>> /* { PCI_VDEVICE(TTI, 0x1740), chip_508x }, */
>>>>
>>>> /* Pozicom: GenII 1740 cards use 88sx6042 chip */
>>>>
>>>> { PCI_VDEVICE(TTI, 0x1740), chip_6042 },
>>>>
>>>> { PCI_VDEVICE(TTI, 0x1742), chip_508x },
>>>>
>>>>
>>>> It appears the same card has different chip set depending upon when
>>>> you purchased your card.  Looking through the code, the GenI vs. GenII
>> vs.
>>>> GenIIe is done after the call to mv_pci_init_one thus passing a table
>>>> of values that are incorrect.  It would appear to make sense to solve
>>>> this by creating two or more tables and make mv_pci_tbl a
>>>> pci_device_id global
>>>> * and
>>>> reference it accordingly after the Rev. level was determined.
> ..
>
> Eric,
>
> I'm patching this (finally, sorry for the delay) for the 2.6.29 kernel.
> Can you confirm that the attached patch works on your system there?
> It should apply/work on any of 2.6.27, 2.6.28, 2.6.29-rc,
> and possibly also on older kernels.
>
> Thanks
> --
> Mark Lord
> Real-Time Remedies Inc.
> mlord@pobox.com
>


