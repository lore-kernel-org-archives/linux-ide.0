From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: IO errors after "block: remove bio_get_nr_vecs()"
Date: Sun, 20 Dec 2015 09:51:14 -0800
Message-ID: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>
Cc: Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Kent, Jens, Christoph et al,
 please see this bugzilla:

  https://bugzilla.kernel.org/show_bug.cgi?id=109661

where Artem Tashkinov bisected his problems with 4.3 down to commit
b54ffb73cadc ("block: remove bio_get_nr_vecs()") that you've all
signed off on.

(Also Tejun - maybe you can see what's up - maybe that error message
tells you something)

I'm not sure what's up with his machine, the disk doesn't seem to be
anyuthing particularly unusual, it looks like a 1TB Seagate Barracuda:

  ata1.00: ATA-8: ST1000DM003-1CH162, CC44, max UDMA/133

which doesn't strike me as odd.

Looking at the dmesg, it also looks like it's a pretty normal
Sandybridge setup with Intel chipset. Artem, can you confirm? The PCI
ID for the AHCI chip seems to be (INTEL, 0x1c02).

Any ideas? Anybody?

                       Linus
