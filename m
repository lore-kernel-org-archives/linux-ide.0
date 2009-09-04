From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH #upstream, v2] ahci: Implement SATA AHCI FIS-based switching support
Date: Fri, 4 Sep 2009 10:25:15 +0800
Message-ID: <C8E4BD7D001E44499280E0884BD9DB30FC9F41@sshaexmb1.amd.com>
References: <1250570756.5207.15.camel@zm-desktop> <4A9B8368.1080807@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9776@sshaexmb1.amd.com> <C8E4BD7D001E44499280E0884BD9DB30FC9C7F@sshaexmb1.amd.com> <4A9F5C56.5010605@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:51007 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077AbZIDCZZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Sep 2009 22:25:25 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <4A9F5C56.5010605@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Tejun, 

> -----Original Message-----
> From: Tejun Heo [mailto:tj@kernel.org] 
> > 
> > At the 2nd thought, if (!pp->fbs_enabled) appears unfortunately
> > (although it should not), replacement of if (pp->fbs_enabled) with
> > BUG_ON() will lead to the execution of the followed DEC,
> 
> Nope, it will result in the executing task being stopped with a scary
> stackdump.


Yes, you are right, I will adopt your suggestion.


Thanks
Shane

