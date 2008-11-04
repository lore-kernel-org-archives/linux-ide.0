From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: hdparm-9.2 now available: w/ DCO and firmware support
Date: Tue, 4 Nov 2008 13:01:15 -0500
Message-ID: <87f94c370811041001ucd76d27lc948c553ad2a381e@mail.gmail.com>
References: <490F4030.5030709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:23329 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425AbYKDSBQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Nov 2008 13:01:16 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1232768yxm.1
        for <linux-ide@vger.kernel.org>; Tue, 04 Nov 2008 10:01:15 -0800 (PST)
In-Reply-To: <490F4030.5030709@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, Nov 3, 2008 at 1:17 PM, Mark Lord <liml@rtr.ca> wrote:
> hdparm v9.2 is now available from sourceforge.
>
>        http://sourceforge.net/projects/hdparm/
>
> New since v8.9 are:
>
> 1. Support for Device Configuration Overlay (DCO),
>  with the --dco-identify, --dco-freeze, and --dco-restore flags.
>  DCO is a feature set that enables vendors/OEMs to disable/hide
>  certain drive features (eg. NCQ, LBA48, ..) for whatever reason
>  (eg. compatibility with a specific b0rked BIOS).
>  This release of hdparm can display/reset DCO, but not selectively
>  disable features yet.
>
> 2. Support for firmware download (upgrade) using the
>  standard ATA DOWNLOAD_MICROCODE protocols 7 (preferred) and 3.
>  This is initiated via the new --fwdownload flag,
>  or the --fwdownload80 flag for a non-standard final packet
>  (needed by some vendors).
>
> 3. Fixed WorldWideName display, and added cache-size display in -I output.
>
> 4. Detect/warn of kernel driver bugs in -N output.
>  Eg. sata_sil24 misbehaves here in 2.6.25, but is fine in 2.6.27.
>
> 5. General fixes and tidiness in the sg16 routines.

Mark,

I'm very happy to see the DCO support go in.

There is a small army of "Computer Forensic" examiners which do their
forensic imaging via Linux and I'm sure many will feel the same.

Thanks
Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
