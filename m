From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: IO_PAGE_FAULT from SATA card during boot
Date: Mon, 21 Feb 2011 10:39:05 +0100
Message-ID: <20110221093905.GE26519@amd.com>
References: <4D49FB9F.9040304@gmail.com>
 <20110203085601.GB2490@arachsys.com>
 <20110207174838.GA21124@arachsys.com>
 <4D50A4B8.2070608@gmail.com>
 <20110208104157.GU2106@amd.com>
 <20110208110036.GA18763@arachsys.com>
 <AANLkTikTBi7FHoXS1JmKXgvmv4j7ramezO09kksGrJA1@mail.gmail.com>
 <20110208144805.GF19483@arachsys.com>
 <20110217094005.GS21289@arachsys.com>
 <4D5DBBD1.5020108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:20906
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751439Ab1BUJjM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Feb 2011 04:39:12 -0500
Content-Disposition: inline
In-Reply-To: <4D5DBBD1.5020108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Chris Webb <chris.webb@elastichosts.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Thu, Feb 17, 2011 at 07:22:41PM -0500, Robert Hancock wrote:
> Also wonder if we could quirk this in the kernel somehow so that IOMMUs 
> wouldn't freak out..

Some kind of quirk will be required for the cards out there. I'll think
about it and post some patches for testing.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

