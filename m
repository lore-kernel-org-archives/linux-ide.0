From: Marc Bevand <bevand_m@epita.fr>
Subject: Re: libata problems with 66Mhz Promise SATA150 TX4
Date: Wed, 15 Sep 2004 15:45:43 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040915134543.GA23786@iah.epita.fr>
References: <m34qm13m8h.fsf@zathras.nivin.org> <41473287.7050101@epita.fr> <20040914191851.A7263@florence.linkmargin.com> <20040915090212.GA3493@hwi.epita.fr> <20040915080812.A7683@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from deliver.epitech.net ([163.5.0.25]:54338 "HELO ideliver")
	by vger.kernel.org with SMTP id S266376AbUIONps (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Sep 2004 09:45:48 -0400
Content-Disposition: inline
In-Reply-To: <20040915080812.A7683@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org

Andy Warner wrote:
| 
| I reconfigured the system so the TX4 was the only adapter on
| the 100MHz PCI-X bus, and re-ran the tests - I'm now seeing ~200MB/s
| with dd (bs=1M) and ~110MB/s with sg_utils. It ran for 9 hours
| overnight without error.

Hmm. I am disappointed :-/

What the hell could be the problem on Paul's system and mine ?
Both of us have a Tyan motherboard (but not the same model).
Common points are:

  - Dual-opteron (the watchdog timeout error is reported by the
    northbridge, built-in the cpu)
  - Hypertransport bus
  - AMD-8131 PCI-X tunnel chip

| Here's the vmstat output you requested.
| [...]

Thanks.

-- 
Marc Bevand                          http://www.epita.fr/~bevand_m
Computer Science School EPITA - System, Network and Security Dept.
