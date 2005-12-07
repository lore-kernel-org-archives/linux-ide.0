From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Date: Wed, 7 Dec 2005 13:14:54 +0000
Message-ID: <20051207131454.GA16558@srcf.ucam.org>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com> <20051206222001.GA14171@srcf.ucam.org> <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:34274 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751038AbVLGNPB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Dec 2005 08:15:01 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>

On Wed, Dec 07, 2005 at 09:17:31AM +0100, Bartlomiej Zolnierkiewicz wrote:

> Isn't ide-io.c:ide_{start,complete}_power_step() enough?

No.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
