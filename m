From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: sata_nv failure on 2.4.18 (Fedora Core 6)
Date: Wed, 25 Oct 2006 15:26:16 +1000
Message-ID: <1161753976.22582.46.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0610242257410.21847@gate.crashing.org>
	 <20061025042811.GJ13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:21735 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1423001AbWJYF0X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Oct 2006 01:26:23 -0400
In-Reply-To: <20061025042811.GJ13677@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Hatle <fray@gate.crashing.org>, linux-ide@vger.kernel.org


> Does the problem occur on 2.6.18 but not on earlier version?  If it
> doesn't happen on 2.6.17, we can rule out h/w problem.

Difficult to say... this is a fresh install of FC6 and it's a production
box (heh, it handles my email !) so we can't easily test plenty
different kernels on it unfortunately... If 2.6.17 can be booted and
works fine on FC6, might be worth giving it a go but I wouldnt' expect
too many tests of that sort.

> * If 2.6.17 shows the same problem : could be a faulty drive or
>   problem in the controller.  NV SATA controllers supply two
>   interfaces - legacy TF/BMDMA and ADMA.  The former tends to react
>   badly when error condition occurs.  Driver for ADMA interface is
>   under development.  It could be that the controller cannot cope with
>   transient transmission errors.  If this is the case, ADMA driver
>   should be able to fix it.

Do we have any contact at nVidia that could rule on that issue ? The
drives both appear to work fine on the SIL controller... 

> * If 2.6.17 doesn't show the same problem : My first suspicion is
>   weird IRQ problem.  Play with the usual IRQ options - acpi, noacpi,
>   etc... and see if anything changes.

Ben.


