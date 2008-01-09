From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: SATA PMP support in 2.6.24-rc3?
Date: Wed, 9 Jan 2008 13:56:30 -0800
Message-ID: <39B20DF628532344BC7A2692CB6AEE07022FA70F@orsmsx420.amr.corp.intel.com>
References: <39B20DF628532344BC7A2692CB6AEE070201BD83@orsmsx420.amr.corp.intel.com> <474CC423.70705@gmail.com> <474E2F5E.1010509@23palmer.net> <47836C36.4040701@gmail.com> <39B20DF628532344BC7A2692CB6AEE07022BC62E@orsmsx420.amr.corp.intel.com> <47845CB9.7040609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36852 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197AbYAIV5D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 16:57:03 -0500
Content-class: urn:content-classes:message
In-Reply-To: <47845CB9.7040609@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Tom Evans <tom@23palmer.net>, linux-ide@vger.kernel.org

>-----Original Message-----
>From: Tejun Heo [mailto:htejun@gmail.com]
>Sent: Tuesday, January 08, 2008 9:34 PM
>To: Gaston, Jason D
>Cc: Tom Evans; linux-ide@vger.kernel.org
>Subject: Re: SATA PMP support in 2.6.24-rc3?
>
>Gaston, Jason D wrote:
>> For reference, here is the dmesg output from the 2.6.24-rc7 kernel
W/O
>> the patch applied.
>
>Man, this is weird.  Do you happen to have a addonics device too?  I
>have one 4726 and two 3726s here and none shows such problem.  Also,
>there are quite a few people confirming that detection is okay on 3726
>and 4726s.
>
>The failure you're seeing is very similar to what happens on my 4726 if
>the first fan-out port is not occupied.  4726 behaves very strangely
>when its first port is empty.  Even BIOS has to time out on 4726 if the
>first port is empty, so I've been thinking it's the peculiarity of the
>chip (and considering the shitty ATA emulation of the pseudo config
>device I'm not surprised).  Also, marvell PMP and new generation of
SIMG
>PMPs (5723 and friends) work fine with the current code.
>
>I've never used windows or the binary only Linux driver.  Do they work
>fine when the first port is unoccupied?  Also, is your PMP from
>addonics?  In most reports, they're saying the array is addonics.  I'm
>not sure whether it's because that vendor is so popular that there
>aren't many alternatives or their hardware is somehow quirky.
>
>--
>Tejun

I am using a Sans Digital PMP, which has a Sil3726CBHU controller in it.
I also have an Addonics PMP and it has the same controller in it.

Jason

