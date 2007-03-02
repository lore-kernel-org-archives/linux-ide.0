From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/3] libata: add missing CONFIG_PM in LLDs
Date: Fri, 02 Mar 2007 21:22:54 +0900
Message-ID: <45E8171E.70205@gmail.com>
References: <20070302083001.GK20322@htj.dyndns.org>	<20070302083126.GL20322@htj.dyndns.org>	<20070302125732.2eb9e67e@lxorguk.ukuu.org.uk>	<45E81266.3060108@gmail.com> <20070302131925.78b00f7d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:56983 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423052AbXCBMWz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Mar 2007 07:22:55 -0500
Received: by nz-out-0506.google.com with SMTP id s1so834876nze
        for <linux-ide@vger.kernel.org>; Fri, 02 Mar 2007 04:22:55 -0800 (PST)
In-Reply-To: <20070302131925.78b00f7d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Fri, 02 Mar 2007 21:02:46 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Alan Cox wrote:
>>> Ughhhhhhhhh...
>>>
>>> Can we not just provide dummy methods ?
>> I agree that it's ugly but LDDs often wrap standard routines and with
>> the third patch all standard routines are gone thus forcing LLDs to omit
>> PM functions if !CONFIG_PM.  If we supply dummy core functions, forcing
>> LLDs to skip private PM functions is difficult.
> 
> If CONFIG_PM is not defined then they will not get called and they
> generally wrap the functions that would become dummies ?
> 
> Am I missing something ?

The PM codes in LLDs would still be compiled and linked in.  Some people
(understandably) seem to be quite concerned about that.  If we determine
that's okay, we can kill CONFIG_PM's in all LLDs.

-- 
tejun
