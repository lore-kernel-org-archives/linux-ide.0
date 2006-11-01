From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: AHCI should try to claim all AHCI controllers
Date: Wed, 01 Nov 2006 00:11:00 -0500
Message-ID: <45482C64.2020902@pobox.com>
References: <FFECF24D2A7F6D418B9511AF6F358602F2CE9E@shacnexch2.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:22235 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161664AbWKAFLF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 00:11:05 -0500
In-Reply-To: <FFECF24D2A7F6D418B9511AF6F358602F2CE9E@shacnexch2.atitech.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Conke Hu <conke.hu@amd.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Conke Hu wrote:
> Hi all,
> 	According to PCI 3.0 spec, ACHI's PCI class code is 0x010601,
> and I suggest the ahci driver had better try to claim all ahci
> controllers, pls see the following patch:

BTW, make sure to always include a Signed-off-by: line in every patch.

See http://linux.yyz.us/patch-format.html and 
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt and 
Documentation/SubmittingPatches (in the kernel source tree).

	Jeff


