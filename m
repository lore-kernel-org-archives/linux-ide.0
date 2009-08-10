From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Export AHCI capabilities
Date: Mon, 10 Aug 2009 14:36:28 +0100
Message-ID: <20090810133628.GA22763@srcf.ucam.org>
References: <1247854427-3315-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57650 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216AbZHJNgb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Aug 2009 09:36:31 -0400
Content-Disposition: inline
In-Reply-To: <1247854427-3315-1-git-send-email-mjg@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On Fri, Jul 17, 2009 at 07:13:47PM +0100, Matthew Garrett wrote:
> AHCI exports various capability bits that may be of interest to userspace
> such as whether the BIOS claims a port is hotpluggable or eSATA. Providing
> these via sysfs along with the version of the AHCI spec implemented by
> the host allows userspace to make policy decisions for things like ALPM.

Any feedback on this?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
