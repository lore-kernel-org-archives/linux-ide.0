From: Tejun Heo <tj@kernel.org>
Subject: Re: HighPoint RocketRAID 2320
Date: Tue, 04 Aug 2009 20:55:27 +0900
Message-ID: <4A7821AF.9010609@kernel.org>
References: <20090803201836.GD13863@dsg.to> <20090803203139.GE13863@dsg.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49630 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753459AbZHDL4C (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Aug 2009 07:56:02 -0400
In-Reply-To: <20090803203139.GE13863@dsg.to>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Dav=ED=F0_Steinn_Geirsson?= <david@dsg.to>
Cc: linux-ide@vger.kernel.org

Hello,

What happens if you specify "libata.force=noncq"?

-- 
tejun
