From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] libata: fallback to the other IDENTIFY on device error, take#2
Date: Sun, 13 May 2007 14:13:44 -0400
Message-ID: <20070513181344.GG27604@redhat.com>
References: <20070501131818.GA18521@electro-mechanical.com> <46374354.7040307@gmail.com> <20070501172117.GA20328@electro-mechanical.com> <463F56F2.3010106@gmail.com> <4642627A.4030606@garzik.org> <46446311.3000208@gmail.com> <4644E9E5.3000402@garzik.org> <46470B48.7050101@gmail.com> <20070513161353.GB29024@redhat.com> <46474FD8.2070100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:53253 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759484AbXEMSO2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 May 2007 14:14:28 -0400
Content-Disposition: inline
In-Reply-To: <46474FD8.2070100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, William Thompson <wt@electro-mechanical.com>, Mark Lord <liml@rtr.ca>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com

On Sun, May 13, 2007 at 07:50:16PM +0200, Tejun Heo wrote:
 > > Otherwise, as Jeff mentions, you're doing a redundant assignment
 > > in the else branch.
 > 
 > Hmmm... I'm feeling very dense today.  At that point, class is either
 > ATA_DEV_ATA or ATA_DEV_ATAPI.  The if-else clause tries to flip between
 > the two.
 > 
 > 1. if class == ATA_DEV_ATA, the 'if' test succeeds and "class =
 > ATA_DEV_ATAPI" runs, so it flips correctly.
 > 
 > 2. if class == ATA_DEV_ATAPI,  the 'if' test fails and "class =
 > ATA_DEV_ATA" runs, so it flips correctly.
 > 
 > What am I missing here?  Feel free to scream at me and hammer me into
 > senses.  :-)

actually, I think I'm denser today. Ignore that last mail.

	Dave

-- 
http://www.codemonkey.org.uk
