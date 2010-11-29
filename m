From: Tejun Heo <tj@kernel.org>
Subject: Re: Regression between 2.6.34 and 2.6.35 ?
Date: Mon, 29 Nov 2010 17:01:44 +0100
Message-ID: <4CF3CE68.2020500@kernel.org>
References: <AANLkTi=g4F0mgS-w2jFs0r_PAcEk5bytdyAGP+rWJ-J5@mail.gmail.com>	<4CEFC051.7090800@kernel.org> <AANLkTi=koJHKvqv6iuvuc-j3HGtSR+YJqaDQmM9JrViO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54414 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422Ab0K2QBr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Nov 2010 11:01:47 -0500
In-Reply-To: <AANLkTi=koJHKvqv6iuvuc-j3HGtSR+YJqaDQmM9JrViO@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Antonio Toma <antonio.toma@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

On 11/28/2010 08:39 PM, Antonio Toma wrote:
> thanks for your reply.
> Here is the output from the cat command and boot logs.
> I included kern, syslog and debug.
> Let me know if there is some other info that could help debugging.

Hmmm... interesting.  Your machine definitely is screwed up but the EH
behavior changed for worse too.  I've been looking through the changes
but can't quite put my finger on what's going wrong.  Can you please
build and test 2.6.36.1?  If the problem is still there, I'll send you
debug patches to track down what's going on.

Thank you.

-- 
tejun
