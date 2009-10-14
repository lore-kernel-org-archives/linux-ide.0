From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_sc1200: Fix crash on boot
Date: Wed, 14 Oct 2009 13:00:46 +0100
Message-ID: <20091014130046.0aa13166@lxorguk.ukuu.org.uk>
References: <20091006150737.9610.81541.stgit@localhost.localdomain>
	<20091013185637.870369c8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51082 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750769AbZJNMBR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Oct 2009 08:01:17 -0400
In-Reply-To: <20091013185637.870369c8.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alan Cox <alan@linux.intel.com>, jeff@garzik.org, linux-kernel@vger.kernel.org, stable@kernel.org, "Alexandros C. Couloumbis" <alex@ozo.com>, linux-ide@vger.kernel.org

> This patch applies to 2.6.31 and 2.6.30 (at least).  How far back
> should it be ported?

No idea. I was just getting it fixed for the maintainer while waiting for
something else to build.
