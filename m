From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Thu, 10 Sep 2009 12:24:14 GMT
Message-ID: <200909101224.n8ACOEvF011088@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:59647 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402AbZIJWE1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Sep 2009 18:04:27 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n8AM46AU021183
	for <linux-ide@vger.kernel.org>; Thu, 10 Sep 2009 22:04:30 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #49 from David Woodhouse <dwmw2@infradead.org>  2009-09-10 12:23:24 ---
http://david.woodhou.se/cimg2777.jpg

(gdb) list *cdrom_newpc_intr + 0x72b
0xe56 is in cdrom_newpc_intr (drivers/ide/ide-cd.c:692).
687                    rq->resid_len += cmd->last_xfer_len;
688            }
689    
690            ide_complete_rq(drive, uptodate ? 0 : -EIO, blk_rq_bytes(rq));
691    
692            if (sense && rc == 2)
693                ide_error(drive, "request sense failure", stat);
694        }
695        return ide_stopped;
696    }

(gdb) list *ide_complete_rq+0x1f
0xffffffff812f0cd6 is in ide_complete_rq (drivers/ide/ide-io.c:125).
120    
121        /*
122         * if failfast is set on a request, override number of sectors
123         * and complete the whole request right now
124         */
125        if (blk_noretry_request(rq) && error <= 0)
126            nr_bytes = blk_rq_sectors(rq) << 9;
127    
128        rc = ide_end_rq(drive, rq, error, nr_bytes);
129        if (rc == 0)
(gdb) list *ide_complete_rq+0x37
0xffffffff812f0cee is in ide_complete_rq (drivers/ide/ide-io.c:129).
124         */
125        if (blk_noretry_request(rq) && error <= 0)
126            nr_bytes = blk_rq_sectors(rq) << 9;
127    
128        rc = ide_end_rq(drive, rq, error, nr_bytes);
129        if (rc == 0)
130            hwif->rq = NULL;
131    
132        return rc;
133    }

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
