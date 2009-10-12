From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.{30,31} x86_64 ahci problem - irq 23: nobody cared
Date: Mon, 12 Oct 2009 18:52:32 +0900
Message-ID: <4AD2FC60.8080705@kernel.org>
References: <4ABBB8C2.2080901@sbg.ac.at> <200910101513.51320.elendil@planet.nl> <4AD2DFA4.9000602@kernel.org> <200910121148.16439.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57146 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754902AbZJLJxS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Oct 2009 05:53:18 -0400
In-Reply-To: <200910121148.16439.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Alexander Huemer <alexander.huemer@sbg.ac.at>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Frans Pop wrote:
> On Monday 12 October 2009, Tejun Heo wrote:
>> Alexander, can you please attach full boot log and the output of
>> "lspci -nn"?  Also, how reproducible is the problem?  You already
>> answered to Frans' question but can you be more specific?
> 
> Full dmesg was made available earlier at:
> http://xx.vu/~ahuemer/dmesg_ahuemer_20090923

Does blacklisting i801_smbus make any difference?

-- 
tejun
