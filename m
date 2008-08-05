From: Eric Piel <eric.piel@tremplin-utc.net>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Tue, 05 Aug 2008 17:14:02 +0200
Message-ID: <48986E3A.5020707__1168.84530657462$1217951031$gmane$org@tremplin-utc.net>
References: <fa.nx0yFPJm+aNXPHgykUrOzZXvvIs@ifi.uio.no> <fa.NfEr7Ik6e8oextyWICW/jR5emeE@ifi.uio.no> <fa.zGvATZImeUo0tHJe4hzlk5+mTiM@ifi.uio.no> <fa.SRVleMItV5QEF7/tgCjSHz0ScJA@ifi.uio.no> <fa.YKbhgq8XUxH/Qg1ArE+73YsDlpE@ifi.uio.no> <4897D16F.3000504@shaw.ca> <20080805131417.GC8569@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:29913 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756218AbYHEPmk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Aug 2008 11:42:40 -0400
In-Reply-To: <20080805131417.GC8569@mit.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>, Robert Hancock <hancockr@shaw.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Gabor Gombas <gombasg@sztaki.hu>, Tejun Heo <htejun@gmail.com>Elias Oltmanns <e>

Theodore Tso schreef:
> The real right answer though is to buy one of the laptop drives (such
> as the Seagate Momentus 7200.2 or 7200.3) which has the anti-shock
> detection built directly into the hard drive.  That way you don't have
> to have a daemon that sits in the OS waking up the CPU some 20 to 30
> times a second and burning up your battery even when the laptop is
> idle.
Well, it's not always _that_ bad. For instance, the accelerometer in the 
HP laptops (lis3lv02dl) can monitor free-falls by itself. When the 
laptop starts falling, it generates one interrupt.

Eric
