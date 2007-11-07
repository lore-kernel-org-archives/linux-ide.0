From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Bugme-new] [Bug 9320] New: PATA scan: ACPI Exception AE_AML_PACKAGE_LIMIT... is beyond end of object
Date: Wed, 7 Nov 2007 22:24:24 +0000
Message-ID: <20071107222423.GA22731@srcf.ucam.org>
References: <bug-9320-10286@http.bugzilla.kernel.org/> <20071107140754.becad267.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:56785 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbXKGWYj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Nov 2007 17:24:39 -0500
Content-Disposition: inline
In-Reply-To: <20071107140754.becad267.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, bruinjm@xs4all.nl, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, Nov 07, 2007 at 02:07:54PM -0800, Andrew Morton wrote:

> Seems to be another post-2.6.23 regression.  Is it an acpi thing or an ata
> thing, of just something which the new acpi+ata stuff exposed??

I suspect that this is just because acpi is enabled by default on ata 
now. Is it actually causing any problems?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
