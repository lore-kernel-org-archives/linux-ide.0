From: Jim Duda <jim@duda.tzo.com>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Sun, 09 Aug 2009 22:28:43 -0400
Message-ID: <4A7F85DB.40604@duda.tzo.com>
References: <h5kn9c$51r$1@ger.gmane.org> <20090809072823.GA2130@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:54981 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754562AbZHJC2z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Aug 2009 22:28:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MaKd4-0001Tu-Le
	for linux-ide@vger.kernel.org; Mon, 10 Aug 2009 02:28:54 +0000
Received: from pool-96-252-13-163.bstnma.fios.verizon.net ([96.252.13.163])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 10 Aug 2009 02:28:54 +0000
Received: from jim by pool-96-252-13-163.bstnma.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 10 Aug 2009 02:28:54 +0000
In-Reply-To: <20090809072823.GA2130@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org

On 08/09/2009 03:28 AM, Borislav Petkov wrote:
>
> If you'd like to test patches you can get Dave's linux-next git repo at
> http://git.kernel.org/?p=linux/kernel/git/davem/ide-next-2.6.git;a=summary
>
> apply the patch below and catch all boot output from your machine and
> send it to me.
>

Okay, I'm running the davem/ide-net-2.6.git version with your patch 
below.  My dmesg startup messages for ide-tape are below.  Is this what 
you were hoping to see?

ide-tape: idetape_do_request: cmd: 0x12, sector: 18446744073709551615, 
nr_sectors: 0
ide-tape: ide_tape_issue_pc: retry #0, cmd: 0x12
ide-tape: ide_tape_callback: cmd: 0x12, dsc: 0, err: 0
ide-tape: hdd <-> ht0: Seagate STT20000A rev 8A51
ide-tape: idetape_do_request: cmd: 0x1a, sector: 18446744073709551615, 
nr_sectors: 0
ide-tape: ide_tape_issue_pc: retry #0, cmd: 0x1a
ide-tape: idetape_do_request: cmd: 0x3, sector: 18446744073709551615, 
nr_sectors: 0
ide-tape: ide_tape_issue_pc: retry #0, cmd: 0x03
ide-tape: ide_tape_callback: cmd: 0x3, dsc: 0, err: 0
ide-tape: idetape_analyze_error: cmd: 0x3, sense key = 6, asc = 28, ascq = 0
ide-tape: idetape_do_request: cmd: 0x1a, sector: 18446744073709551615, 
nr_sectors: 0
ide-tape: ide_tape_issue_pc: retry #1, cmd: 0x1a
ide-tape: ide_tape_callback: cmd: 0x1a, dsc: 0, err: 0
ide-tape: idetape_do_request: cmd: 0x1a, sector: 18446744073709551615, 
nr_sectors: 0
ide-tape: ide_tape_issue_pc: retry #0, cmd: 0x1a
ide-tape: ide_tape_callback: cmd: 0x1a, dsc: 0, err: 0
ide-tape: ide_tape_get_bsize_from_bdesc: blk_size: 512, write_prot: 0
ide-tape: hdd <-> ht0: 232KBps, 6*54kB buffer, 400ms tDSC
U



