From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Wed, 18 Aug 2010 16:15:21 +0100
Message-ID: <20100818161521.430ba361@lxorguk.ukuu.org.uk>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>
	<4C6AB68D.8000102@kernel.org>
	<20100817174257.3691ed68@lxorguk.ukuu.org.uk>
	<4C6AB919.7060203@kernel.org>
	<20100817180158.179e7780@lxorguk.ukuu.org.uk>
	<4C6ABFFA.2000502@kernel.org>
	<20100817192353.3529733c@lxorguk.ukuu.org.uk>
	<4C6B7B72.4090405@kernel.org>
	<20100818110306.03ce2fbc@lxorguk.ukuu.org.uk>
	<4C6BE9C8.4030803@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34355 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752833Ab0HRPAS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Aug 2010 11:00:18 -0400
In-Reply-To: <4C6BE9C8.4030803@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, jeff@garzik.org

> That's the reason why we have module priorities.  The link priority
> becomes module priority and modprobe will deterministically prefer
> ata_piix over ata_generic if a controller is supported by both.

Sure - but if ata_generic is already compiled in or already loaded ?
