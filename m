From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET #upstream] libata: improve timeout handling for EH
 commands
Date: Thu, 29 May 2008 10:59:32 +0900
Message-ID: <483E0E04.70706@gmail.com>
References: <12112174741373-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:15161 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbYE2B7q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 21:59:46 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2785085wfd.4
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 18:59:45 -0700 (PDT)
In-Reply-To: <12112174741373-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca

Tejun Heo wrote:
> Hello,
> 
> [S]ATA has lots of legacy and not in a too healthy way.  The desparate
> efforts to keep everything compatible made mundane things quite
> challenging.  Probing definitely is one of them.  We now span from
> ancient CF devices to port multipliers and quirky ones are easy to
> find all along the spectrum.

Ping.

-- 
tejun
