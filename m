From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v5] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Sun, 11 Jun 2006 23:53:23 -0400
Message-ID: <448CE533.1090607@pobox.com>
References: <1150081562.5721.26.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:8321 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750809AbWFLDxZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jun 2006 23:53:25 -0400
In-Reply-To: <1150081562.5721.26.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: linux-ide@vger.kernel.org

zhao, forrest wrote:
> OK. I ported it to latest #upstream
> 
> Signed-off-by: Zhao, Forrest <forrest.zhao@intel.com>

Patch content looks OK, but

1) "OK. I ported it to latest #upstream" is not a good description :)  I 
use the git-applymbox script to apply the patch, and the full technical 
patch description is copied from your email's message body directly into 
the Linux kernel changelog.

The appropriate place for comments like "OK. I ported it to latest 
#upstream" is following the "---" description terminator line.  See 
Tejun's patches for an example :)


2) Both git-applymbox(1) and patch(1) fail to apply the patch:


[jgarzik@pretzel libata-dev]$ git-applymbox /g/tmp/mbox ~/info/signoff.txt
1 patch(es) to process.

Applying 'Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command'

fatal: corrupt patch at line 84


[jgarzik@pretzel libata-dev]$ patch -sp1 < /g/tmp/mbox
patch: **** malformed patch at line 144: *args,

