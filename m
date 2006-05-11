From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ata_piix failure on ich6m
Date: Thu, 11 May 2006 17:16:40 +0100
Message-ID: <20060511161640.GA24338@srcf.ucam.org>
References: <20060510235650.GA20206@srcf.ucam.org> <44629E68.3020302@gmail.com> <20060511081140.GA21594@srcf.ucam.org> <20060511084541.90d4e071.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:13291 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030314AbWEKQQu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:16:50 -0400
Content-Disposition: inline
In-Reply-To: <20060511084541.90d4e071.rdunlap@xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com

On Thu, May 11, 2006 at 08:45:41AM -0700, Randy.Dunlap wrote:

> Does the 'combined_mode' kernel parameter help any?

Hmm. Slightly awkward to check - it's a modular system with libata in 
initramfs, so getting parameters in may be a pain. However, there's 
nothing on the legacy IDE controller - should combined mode actually 
make a difference in that case? As I said, ahci works fine - the problem 
only occurs with ata_piix. The MAP register indicates that combined mode 
isn't in use.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
