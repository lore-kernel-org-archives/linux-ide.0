From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] When a disk wakes up from sleep, ensure that the command
 	is retried by SCSI EH.
Date: Thu, 22 Apr 2010 19:48:47 +0200
Message-ID: <4BD08BFF.7070702@kernel.org>
References: <4A7CB4D6.7020902@kernel.org>	 <1249687069-31011-1-git-send-email-gwendal@google.com>	 <4A7CB769.4040309@kernel.org> <v2ne7510f761004221043y4b92ab7csa96b5b45fb07ea6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43952 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755072Ab0DVRsz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Apr 2010 13:48:55 -0400
In-Reply-To: <v2ne7510f761004221043y4b92ab7csa96b5b45fb07ea6b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: linux-ide@vger.kernel.org

Hello,

On 04/22/2010 07:43 PM, Gwendal Grignou wrote:
> Just looking into 2.6.33 code, and I did not find this patch. Is there
> anything I should do to have it merge?

I think Jeff just hasn't come around yet.  Please wait a bit more for
Jeff's "applied" mail.  If it doesn't happen in a week or so, pinging
him again would be a good idea.

-- 
tejun
