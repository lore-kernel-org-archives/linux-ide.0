From: Marc Bevand <mb@opensc.org>
Subject: Re: [sata_sil24] v0.10 works, v0.20 doesn't
Date: Wed, 7 Sep 2005 11:37:12 +0200
Message-ID: <20050907093712.GA20006@est.epita.fr>
References: <20050904140239.GA11855@htj.dyndns.org> <loom.20050905T024247-999@post.gmane.org> <431BC732.2010907@gmail.com> <20050905134311.GA15419@est.epita.fr> <20050905230234.GA543@htj.dyndns.org> <20050905231753.GA1003@htj.dyndns.org> <20050906011254.GA23144@est.epita.fr> <20050906015428.GA13521@htj.dyndns.org> <20050906093659.GB14270@est.epita.fr> <20050907013917.GA2803@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from deliver.epitech.net ([163.5.255.125]:10759 "HELO
	deliver.epitech.net") by vger.kernel.org with SMTP id S932079AbVIGJhi
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Sep 2005 05:37:38 -0400
Content-Disposition: inline
In-Reply-To: <20050907013917.GA2803@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Tejun.

Tejun Heo wrote:
| 
|  Here's a big patch against sil24-original branch.  It contains the
| followings.
| 
|  a. build fix & oops fix for sil24-original branch
|  b. backported sata_sil24_new driver
|  c. debug messages (you don't need to turn on ATA_DEBUG)
|  d. 50ms sleep after completion of IDENTIFY before actually reading data
| 
|  Building both sata_sil24 and sata_sil24_new as modules and
| loading/unloading them work on my machine.  Can you please try this
| and let me know how it goes?

Real quick update on this (it's 2:40 am here): sata_sil24_new still
does not detects my disks while sata_sil24 works perfectly. I will post
the full dmesg's + the various things I tried tomorrow.

-- 
 Marc Bevand                              http://epita.fr/~bevand_m
 Computer Science School EPITA - System, Network and Security Dept.
