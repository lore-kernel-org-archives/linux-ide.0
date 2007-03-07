From: =?ISO-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>
Subject: Re: NVIDIA MCP55 NCQ
Date: Wed, 7 Mar 2007 20:17:20 -0300
Message-ID: <0pt3c4-dc3.ln1@tux.abusar.org>
References: <45EF350E.9040205@sauce.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:49620 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992716AbXCGXRq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Mar 2007 18:17:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HP5OB-0005Hr-8I
	for linux-ide@vger.kernel.org; Thu, 08 Mar 2007 00:17:43 +0100
Received: from 200-207-206-233.dsl.telesp.net.br ([200.207.206.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 08 Mar 2007 00:17:43 +0100
Received: from fragabr by 200-207-206-233.dsl.telesp.net.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 08 Mar 2007 00:17:43 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Thu, 08 Mar 2007 10:56:30 +1300
Richard Scobie <richard@sauce.co.nz> wrote:

> Am running a Redhat FC6 machine with kernel 2.6.19-1.2911.6.5 and 
> wondering if there is not yet support for the NCQ feature of sata_nv
> on boards using the NVIDIA MCP55 chipset.

> I get a "permission denied", (as root) and am reluctant to force the 
> issue, as I understand it should all just work, (depth 31/3), if 
> everything is OK.

	The only chipsets supported by sata_nv driver are nForce4
(CK804/MCP04) SATA controllers:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fbbb262d9ea9bdbd79d7058271560e9990bc62d3

	MCP55 isn't supported. On newer chipsets (MCP65, MCP67...)
nvidia moved to AHCI.

	I think that if nobody with the necessary knowledge to support
those chipsets like MCP55 decides to program, we'll be on our
own :( unfortunately.

	I searched nvnews.net forum and it seems nvidia will do nothing
about it... :(

-- 
http://u-br.net
Linux 2.6.20: Homicidal Dwarf Hamster
gcc (GCC) 4.1.2

