From: "Greg Freemyer" <greg.freemyer@norcrossgroup.com>
Subject: Data Recovery from SSDs - Impact of trim?
Date: Fri, 9 Jan 2009 17:27:16 -0500
Message-ID: <87f94c370901091427n74fc8d9apa569c44df12dc099@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:53811 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759468AbZAIW1S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jan 2009 17:27:18 -0500
Received: by qw-out-2122.google.com with SMTP id 3so8708893qwe.37
        for <linux-ide@vger.kernel.org>; Fri, 09 Jan 2009 14:27:16 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dongjun Shin <d.j.shin@samsung.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Dongjun (with linux-ide in copy),

I got your name from a Linux Kernel posting and I was wondering if you
could help me understand if data recovery will be possible with SSDs
in the future.

I work a lot with data recovery and forensic imaging.  With both,
access to what the filesystem considers unallocated sectors / blocks /
clusters is key to the process.  ie. A user deletes a file, but needs
to restore it. Lots of recovery tools exist to assist in this, but
obviously they need to be able to read the no longer allocated
clusters.

With a DISCARD enabled filesystem / kernel and with both current and
future generation SSDs, I'm curious if our tools are going to be able
to read this information anymore.

Per the proposed spec Tejun posted a link to a couple months ago, the
response to a ATA read request of a trimmed sector can either be the
original data or all zeros.

http://t13.org/Documents/UploadedDocuments/docs2007/e07154r3-Data_Set_Management_Proposal_for_ATA-ACS2.pdf

>From my industries perspective we would very much like the original
data to be returned as long as it is available.

Can you provide any insight into how the manufacturers are planning to
implement such reads?

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
