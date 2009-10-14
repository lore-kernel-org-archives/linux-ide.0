From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_sc1200: Fix crash on boot
Date: Wed, 14 Oct 2009 13:38:06 +0100
Message-ID: <20091014133806.63804e19@lxorguk.ukuu.org.uk>
References: <20091006150737.9610.81541.stgit@localhost.localdomain>
	<20091013185637.870369c8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42769 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751749AbZJNMih (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Oct 2009 08:38:37 -0400
In-Reply-To: <20091013185637.870369c8.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alan Cox <alan@linux.intel.com>, jeff@garzik.org, linux-kernel@vger.kernel.org, stable@kernel.org, "Alexandros C. Couloumbis" <alex@ozo.com>, linux-ide@vger.kernel.org

> This patch applies to 2.6.31 and 2.6.30 (at least).  How far back
> should it be ported?

Having had a dig the bug was introduced in
c0f2ee34a5a0b79fd98d965ad8ae765d4639bfa5

I've not however tested the patch with any older releases.

Alan
