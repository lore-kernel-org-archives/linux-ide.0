From: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: SY-KT880 DRAGON 2 (VT8237 and ALi 5281 SATA Chipset Conflict?)
Date: Mon, 20 Sep 2004 21:45:30 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <414F95CA.5070306@clanhk.org>
References: <Pine.LNX.4.44.0409201545500.3505-100000@nakedeye.aparity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:20981 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S267466AbUIUCp0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Sep 2004 22:45:26 -0400
In-Reply-To: <Pine.LNX.4.44.0409201545500.3505-100000@nakedeye.aparity.com>
List-Id: linux-ide@vger.kernel.org
To: "Matt D. Robinson" <matt@aparity.com>
Cc: linux-ide@vger.kernel.org

Matt D. Robinson wrote:

>Hi, all.  The new Soyo SY-KT880 DRAGON 2 uses two separate SATA
>RAID chipsets on the motherboard, the VIA8237 and ALi 5281.
>I'm still testing this, but it looks like only one function is
>loaded at any given time.  Is there a conflict between utilizing
>both devices simultaneously?  I'm trying to use them in non-RAID
>(just SATA) mode so there isn't anything special going on here.
>sata_via.ko doesn't find the ALi 5281 devices (SATA3/4), and the
>VIA8237 (SATA1/2) are recognized just fine.
>  
>
sata_via isn't going to work for an ALi chipset.

-ryan
