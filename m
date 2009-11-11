From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ahci: add parameter to disable ahci driver on Promise
 PDC42819
Date: Wed, 11 Nov 2009 10:37:01 +0000
Message-ID: <20091111103701.11a9d96e@lxorguk.ukuu.org.uk>
References: <65a6ef750911110154h4eff3b9cp4f5259f37834ea7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44905 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751300AbZKKKfH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Nov 2009 05:35:07 -0500
In-Reply-To: <65a6ef750911110154h4eff3b9cp4f5259f37834ea7a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Nelson <mdnelson8@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, 11 Nov 2009 20:54:34 +1100
Mark Nelson <mdnelson8@gmail.com> wrote:

> ahci can drive the Promise PDC42819, but obviously it can only use SATA
> disks connected to this controller. The controller can actually support
> SAS disks as well, but at the moment only with Promise's own binary
> t3sas driver.

That would be a promise problem.

> To allow users to use both the ahci and the t3sas drivers in the same

But you said it was a binary driver, so how can you use it. The kernel is
GPL licensed ?

