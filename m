From: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: Problems with Promise SATAII TX4
Date: Sat, 8 Oct 2005 13:06:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44.0510081259090.28615-100000@coffee.psychology.mcmaster.ca>
References: <4347C5A1.1020504@avona.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:58299 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S932168AbVJHRGc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Oct 2005 13:06:32 -0400
Received: from coffee.psychology.mcmaster.ca (coffee.Psychology.McMaster.CA [130.113.218.59])
	by coriana6.cis.mcmaster.ca (8.12.11/8.12.11) with ESMTP id j98H6UD3015667
	for <linux-ide@vger.kernel.org>; Sat, 8 Oct 2005 13:06:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by coffee.psychology.mcmaster.ca (Postfix) with ESMTP id 1AFE78B25
	for <linux-ide@vger.kernel.org>; Sat,  8 Oct 2005 13:06:30 -0400 (EDT)
In-Reply-To: <4347C5A1.1020504@avona.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> I'm not sure why the system needs more than 430W, but with the new

unfortunately, total watts is inadequate for characterizing a PSU.
it's about like classifying cars by how tall they are.

in particular, many non-server higher-watt PSU's are designed to provide
extra power for systems which consume power mainly on the CPU/video voltages,
and may not provide enough power for disks.  further, modern motherboards
have voltage converters for the CPU and video which are less sensitive 
to power quality, and will thus "brownout" some power buses.  after all, 
a typical CPU wants 1.5V or so at an obscene current.  disk electronics, 
as far as I have seen, tend to treat their supply as clean and regulated.

