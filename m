From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: poor sata performance on 2.6
Date: Thu, 22 Apr 2004 21:50:56 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040423045056.GB881054@sgi.com>
References: <200404150236.05894.kos@supportwizard.com> <200404151826.54488.kos@supportwizard.com> <1082039593.19568.75.camel@lotte.street-vision.com> <200404151848.05857.kos@supportwizard.com> <1082041692.19571.82.camel@lotte.street-vision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mtvcafw.sgi.com ([192.48.171.6]:61095 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264723AbUDWEvt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Apr 2004 00:51:49 -0400
Content-Disposition: inline
In-Reply-To: <1082041692.19571.82.camel@lotte.street-vision.com>
List-Id: linux-ide@vger.kernel.org
To: Justin Cormack <justin@street-vision.com>
Cc: Konstantin Sobolev <kos@supportwizard.com>, linux-ide@vger.kernel.org

It works fine on my SATA disk:

[root@flxible root]# hdparm -Tt /dev/sdb

/dev/sdb:
 Timing buffer-cache reads:   3916 MB in  2.00 seconds = 1956.09 MB/sec
 Timing buffered disk reads:  174 MB in  3.01 seconds =  57.85 MB/sec
