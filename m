From: Paul Collins <paul@burly.ondioline.org>
Subject: [REGRESSION] commit "ide: respect current DMA setting during resume" breaks resume on PowerBook G4
Date: Mon, 08 Dec 2008 14:47:37 +1300
Message-ID: <87wseb8mkm.fsf@burly.wgtn.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755059AbYLHBrw@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@sisk.pl
List-Id: linux-ide@vger.kernel.org

Commit e9eb8388306364295308132265c00bea685f409f ("ide: respect current
DMA setting during resume") breaks resume on my PowerBook G4.

I get a stream of the following:

    hda: task_out_intr: status=0x51 { DriveReady SeekComplete Error }
    hda: task_out_intr: error=0x04 { DriveStatusError }
    ide: failed opcode was: unknown

and generally the machine hangs, although once it reported

    ide0: reset: success

and resumed successfully.

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
