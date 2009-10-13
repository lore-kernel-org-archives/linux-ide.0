From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.{30,31} x86_64 ahci problem - irq 23: nobody cared
Date: Tue, 13 Oct 2009 21:35:05 +0900
Message-ID: <4AD473F9.7090606@kernel.org>
References: <4ABBB8C2.2080901@sbg.ac.at> <200910101513.51320.elendil@planet.nl> <4AD2DFA4.9000602@kernel.org> <200910121148.16439.elendil@planet.nl> <4AD2FC60.8080705@kernel.org> <4AD2FD10.2010800@sbg.ac.at> <4AD2FFC7.5010402@kernel.org> <4AD300B5.6080102@sbg.ac.at> <4AD34554.3050701@sbg.ac.at> <4AD3E348.5030508@kernel.org> <4AD422F2.4080308@sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42133 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759440AbZJMMgL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Oct 2009 08:36:11 -0400
In-Reply-To: <4AD422F2.4080308@sbg.ac.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Huemer <alexander.huemer@sbg.ac.at>
Cc: Jean Delvare <jdelvare@suse.de>, Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Alexander Huemer wrote:
> i compiled gcc in a loop over night, 14 times. no error.
> it really seams i2c_i801 was the cause...
> unfortunately i still don't know how i can extract the part of the gcc
> compilation process that causes the error on an affected kernel.
> that would enable me to create a simple test program.

Given that i2c is used for temperature monitoring, I think it is not
triggered by any single step of the compiling but rather by the
accumulated heat load during compilation.  Let's wait for Jean to
chime in.  :-)

Thanks.

-- 
tejun
