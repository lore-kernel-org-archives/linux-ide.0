From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Export AHCI capabilities
Date: Sat, 18 Jul 2009 06:02:33 +0100
Message-ID: <20090718050233.GA18236@srcf.ucam.org>
References: <1247854427-3315-1-git-send-email-mjg@redhat.com> <4A61544B.5030403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45576 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbZGRFCh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Jul 2009 01:02:37 -0400
Content-Disposition: inline
In-Reply-To: <4A61544B.5030403@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

On Fri, Jul 17, 2009 at 10:49:15PM -0600, Robert Hancock wrote:

> Surely there's a better format for exporting this information to  
> userspace than making it parse out the bits from the raw register  
> contents.. how about separate sysfs files for ESP, HPCP, etc? Or  
> something more abstracted at a higher level that other drivers (if they  
> have access to similar information) could use?

I could split out more of the information, but there's a balance between 
exposing enough that we won't need to add more values in the near future 
and ending up with one sysfs file for pretty much every capabilities 
bit. I'm not aware of any cases where we can currently generalise this 
to other controllers, but I'm happy to be proven wrong on that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
