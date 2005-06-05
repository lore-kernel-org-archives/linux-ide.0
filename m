From: Greg Stark <gsstark@mit.edu>
Subject: Re: [SATA] libata-dev queue updated
Date: 04 Jun 2005 22:25:17 -0400
Message-ID: <87k6l9k0aa.fsf@stark.xeocode.com>
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>
	<42A1E96C.6080806@pobox.com> <20050604185028.GZ4992@stusta.de>
	<42A1FB91.5060702@pobox.com> <87psv2j5mb.fsf@stark.xeocode.com>
	<20050604191958.GA13111@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stark.xeocode.com ([216.58.44.227]:43437 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261403AbVFECZd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Jun 2005 22:25:33 -0400
In-Reply-To: <20050604191958.GA13111@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg Stark <gsstark@mit.edu>, Adrian Bunk <bunk@stusta.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, James Bottomley <James.Bottomley@steeleye.com>


Jeff Garzik <jgarzik@pobox.com> writes:

> On Sat, Jun 04, 2005 at 03:15:24PM -0400, Greg Stark wrote:
> > So my question is, if I did tackle this riddle trail and figured out how to
> > fetch the passthru branch against 2.6.12, what would it buy me? Would SMART
> > just start working? Or would it just confuse the SMART tools until they're
> > updated? Or would it just crash my machine?
> 
> SMART should just start working.  It adds the ioctls that existing smartd
> and hdparm already know about.

So, uh, where do I get git? Where is your "git repository" and Linus' "git
repository" and how do I set that up?

Or, at least, where do I find all this info?


I take it it's not this:

Package: git
Priority: optional
Section: utils
Installed-Size: 919
Maintainer: Ian Beckwith <ianb@nessie.mcc.ac.uk>
Architecture: i386
Version: 4.3.20-7
Depends: libc6 (>= 2.3.2.ds1-4), libncurses5 (>= 5.4-1), libreadline4 (>= 4.3-1)
Filename: pool/main/g/git/git_4.3.20-7_i386.deb
Size: 261822
MD5sum: a708688e17259ed1e99d2828e1acb3f6
Description: GNU Interactive Tools, a file browser/viewer and process viewer/killer
 git (GNU Interactive Tools) is a set of interactive text-mode tools,
 closely integrated with the shell.  It contains an extensible file
 system browser, an ascii/hex file viewer, a process viewer/killer and
 some other related utilities and shell scripts.  It can be used to
 increase the speed and efficiency of most of the daily tasks such as
 copying and moving files and directories, invoking editors,
 compressing and uncompressing files, creating and expanding archives,
 compiling programs, sending mail, etc.  It looks nice, has colors (if
 the standard ANSI color sequences are supported) and is user-friendly.
 .
 One of the main advantages of Git is its flexibility.  It is not
 limited to a given set of commands.  The configuration file can be
 easily enhanced, allowing the user to add new commands or file
 operations, depending on its needs or preferences.


-- 
greg

