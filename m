From: Marc Bevand <bevand_m@epita.fr>
Subject: Re: libata problems with 66Mhz Promise SATA150 TX4
Date: Wed, 15 Sep 2004 11:02:12 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040915090212.GA3493@hwi.epita.fr>
References: <m34qm13m8h.fsf@zathras.nivin.org> <41473287.7050101@epita.fr> <20040914191851.A7263@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from deliver.epitech.net ([163.5.0.25]:62021 "HELO ideliver")
	by vger.kernel.org with SMTP id S264261AbUIOJCP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Sep 2004 05:02:15 -0400
Content-Disposition: inline
In-Reply-To: <20040914191851.A7263@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org

Andy Warner wrote:
| [...]
| I'm observing a lower throughput than that, though ~60MB/s; so I'm
| going to check to see if there is something else throttling
| performance, below the point of failure.

Personally, I am using a blocksize of 32k with 'dd' in order to reach
215 MB/s, and I set the readahead to 256 on all the disks:

  $ blockdev --setra 256 /dev/sdX

To satisfy my curiosity, could you sent me an excerpt of 'vmstat 1' while
stressing your disks like this ? Thanks.

-- 
Marc Bevand                          http://www.epita.fr/~bevand_m
Computer Science School EPITA - System, Network and Security Dept.
