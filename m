From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: sata_nv frees DMA memory with different size (possibly a
 generic  libata bug)
Date: Sun, 22 Feb 2009 18:39:09 +0900
Message-ID: <20090222183910I.fujita.tomonori@lab.ntt.co.jp>
References: <20090221155724W.fujita.tomonori@lab.ntt.co.jp>
	<d676b7a80902210157l47344e77yb5b36c67e3750ad7@mail.gmail.com>
	<49A04FDD.4070101@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:55690 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617AbZBVJjb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Feb 2009 04:39:31 -0500
In-Reply-To: <49A04FDD.4070101@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hancockrwd@gmail.com
Cc: wes.shull@gmail.com, fujita.tomonori@lab.ntt.co.jp, cebbert@redhat.com, linux-ide@vger.kernel.org

On Sat, 21 Feb 2009 13:02:53 -0600
Robert Hancock <hancockrwd@gmail.com> wrote:

> I suppose it makes sense it wouldn't fix this particular problem, though 
> I think the patch is still correct (and Fujita should likely push it for 
> -next). In this case it's complaining about a mismatch of one of the 
> element sizes, not the number of elements which is what it was fixing

Yeah, you are right. The patch is correct. But after rereading the
dma-debug code, I'm sure that the patch doesn't fix this problem.


> Fujita, do you know if there is some other kind of merging that the GART 
> IOMMU code could be doing that would be tripping up this debug code?

Unfortunately, I don't now... I'll check the code later.
