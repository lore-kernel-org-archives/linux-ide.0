From: Marc Bevand <bevand_m@epita.fr>
Subject: Re: (SOLVED) Generic bug/race in the IDE/SATA code ?
Date: Mon, 25 Oct 2004 01:58:05 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041024235805.GA19584@iah.epita.fr>
References: <20041020122917.GA6896@iah.epita.fr> <m36551gd82.fsf@zathras.nivin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from deliver.epitech.net ([163.5.0.25]:55842 "HELO
	ideliver.epitech.net") by vger.kernel.org with SMTP id S261628AbUJXX6S
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Oct 2004 19:58:18 -0400
Content-Disposition: inline
In-Reply-To: <m36551gd82.fsf@zathras.nivin.org>
List-Id: linux-ide@vger.kernel.org
To: Paul Fisher <rao@gnu.org>
Cc: linux-ide@vger.kernel.org, corvus@gnu.org

Paul Fisher wrote:
| Marc Bevand <bevand_m@epita.fr> writes:
| 
| > Paul: can you try 2.6.9 and confirm this ?
| 
| Can't confirm.  Same problems with 2.6.9.  

I double-checked my system, and I was wrong: actually I can
reproduce the watchdog timeout with 2.6.9, like you (I inadver-
tently left a maxcpus=1 boot param in my grub.conf).

The fact that a non-SMP kernel (or SMP with maxcpus=1) does
reduce the probability of watchdog timeouts looks suspicious...

-- 
Marc Bevand                          http://www.epita.fr/~bevand_m
Computer Science School EPITA - System, Network and Security Dept.
