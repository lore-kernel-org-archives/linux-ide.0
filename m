From: Jim Paris <jim@jtan.com>
Subject: Re: sata_promise TX2/TX4 cards rejecting smart auto-offline & auto-save ata cmds?
Date: Mon, 29 Jan 2007 02:48:44 -0500
Message-ID: <20070129074844.GA15177@jim.sh>
References: <76366b180610292250n400fff81s76a2a9cd84d61366@mail.gmail.com> <4545A74E.8020604@gmail.com> <76366b180610292331t6827f0ddl54ffe24be39dea2c@mail.gmail.com> <4545AD0B.1030903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:53951 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933118AbXA2Hs7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 02:48:59 -0500
Content-Disposition: inline
In-Reply-To: <4545AD0B.1030903@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: Andrew Paprocki <andrew@ishiboo.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Andrew Paprocki wrote:
> >On 10/30/06, Tejun Heo <htejun@gmail.com> wrote:
> >>Please read the following thread.
> >>
> >>http://thread.gmane.org/gmane.linux.ide/13222/focus=13235
> >
> >Worked like a charm! Just patched up smartmontools now and I don't get
> >the failed cmds anymore. Hope Bruce takes that patch soon.
> 
> Bruce took the patch and it will be included in the next version of 
> smartmontools.  :-)

Hello Tejun, Bruce,

Sorry to bring up an old thread, but it looks like this patch did not
actually make it into smartmontools 5.37 or CVS.  Tejun, could you
please take another look and update the patch?  There's a new user of
STRANGE_BUFFER_LENGTH and I don't know enough about the code to fix
it properly.

-jim
