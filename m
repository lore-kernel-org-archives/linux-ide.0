From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Thu, 29 May 2008 15:49:34 +0100
Message-ID: <20080529144934.GA24382@srcf.ucam.org>
References: <20080528143857.GB5585@homac.suse.de> <20080529132253.GA22309@srcf.ucam.org> <483EB33D.6010101@gmail.com> <20080529140213.GA23373@srcf.ucam.org> <20080529141421.GC9268@homac.suse.de> <20080529143541.GA24013@srcf.ucam.org> <483EBFC5.7020406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58939 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbYE2Ot4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 May 2008 10:49:56 -0400
Content-Disposition: inline
In-Reply-To: <483EBFC5.7020406@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

Got it. It works if I lose the ata_port_freeze() from 
ata_acpi_detach_device. 

-- 
Matthew Garrett | mjg59@srcf.ucam.org
