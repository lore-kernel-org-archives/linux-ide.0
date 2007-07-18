From: Thorsten Leemhuis <fedora@leemhuis.info>
Subject: Re: Kernel bug in Fedora 7.
Date: Wed, 18 Jul 2007 09:00:46 +0200
Message-ID: <469DBA9E.3000205@leemhuis.info>
References: <200707172325.37021.mirsev@cicese.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tzmxr02.htp-tel.de ([81.14.243.18]:65399 "EHLO
	TZMXR02.htp-tel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbXGRHAv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 03:00:51 -0400
In-Reply-To: <200707172325.37021.mirsev@cicese.mx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Serguei Miridonov <mirsev@cicese.mx>, IDE/ATA development list <linux-ide@vger.kernel.org>



On 18.07.2007 08:25, Serguei Miridonov wrote:
> [...]
> P.S. I could download the newer kernel 2.6.22 from kernel.org 
> and compile it myself but I'm not sure if any additional 
> patches were applied to 2.6.21 which is necessary for Fedora 
> 7.

There is a new kernel based on 2.6.22 in updates-testing (version
kernel-2.6.22.1-20.fc7); if you want to try that one just run

# yum --enablerepo=updates-testing update kernel

and reboot.

> [...]

CU
knurd
