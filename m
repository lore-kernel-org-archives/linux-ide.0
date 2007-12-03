From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: Enabling MSI in sata_nv
Date: Mon, 3 Dec 2007 13:55:51 -0500
Message-ID: <87f94c370712031055h4c359ee9w59fd076fedcc8b9f@mail.gmail.com>
References: <47537304.2030801@overt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:30918 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbXLCSzw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 13:55:52 -0500
Received: by an-out-0708.google.com with SMTP id d31so770366and
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2007 10:55:51 -0800 (PST)
In-Reply-To: <47537304.2030801@overt.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philip Langdale <philipl@overt.org>
Cc: linux-ide@vger.kernel.org

On Dec 2, 2007 10:07 PM, Philip Langdale <philipl@overt.org> wrote:
> Hi all,
>
> At least for my hardware (MCP55), the sata controller supports MSI
> and it seems that turning it on is as simple as inserting the call
> to pci_enable_msi - after that it Just Works(tm).
>
> Are there any gotchas that I'm missing? Would a patch to do this
> be accepted?
>
> --phil

I don't know if it is relevant, but I had to disable MSI to get a
MCP55 NIC to work under 2.6.22.

See https://bugzilla.novell.com/show_bug.cgi?id=287017#c1 for details
if your curious.

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
