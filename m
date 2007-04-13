From: Jim Paris <jim@jtan.com>
Subject: Re: sata_sil24 and Port Multiplier
Date: Thu, 12 Apr 2007 23:27:16 -0400
Message-ID: <20070413032716.GA9216@jim.sh>
References: <31391147.95001176417197048.JavaMail.servlet@perfora>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:36188 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191AbXDMD1S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Apr 2007 23:27:18 -0400
Content-Disposition: inline
In-Reply-To: <31391147.95001176417197048.JavaMail.servlet@perfora>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell <russell.sloan@lingua-data.com>
Cc: linux-ide@vger.kernel.org

> I've read somewhere that there's a version of the sata_sil24 driver
> that Tejun Heo added support for port multipliers.  Can someone
> please tell me where to get the latest version or patch for this??

The libata-tj-2.6.17.4 and libata-tj-2.6.18.1 patches at 

  http://home-tj.org/wiki/index.php/Libata-tj-stable

have port multiplier support.  Also, see
  
  http://www.mail-archive.com/linux-ide@vger.kernel.org/msg04062.html

-jim
