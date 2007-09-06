From: Steve McIntyre <steve@einval.com>
Subject: Bug#419482: Kernel 2.6.18 - ALI15X3 driver too optmistic about UDMA
Date: Thu, 6 Sep 2007 23:27:59 +0100
Message-ID: <20070906222759.GI29259@einval.com>
References: <20070415232959.GE25207@einval.com> <20070416012635.GA29219@deprecation.cyrius.com> <20070418212536.GC30335@einval.com>
Reply-To: Steve McIntyre <steve@einval.com>, 419482@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.419482.B419482.118911760713940@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20070418212536.GC30335@einval.com>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: linux-ide@vger.kernel.org
Cc: 419482@bugs.debian.org
List-Id: linux-ide@vger.kernel.org

Hi,

I reported this problem initially to the Debian BTS back in April, but
I've not had a chance to follow up on it since - the moment I got the
system up and running again, it needed to keep running as a build
daemon for us. Now I've got some downtime to allow me to delve
further...

On the "cats" machines that we use for arm buildd work, it seems the
kernel is too aggressive in enabling UDMA support for the onboard IDE
chip:

  ALi Corporation M5229 IDE (rev c1)

aka

00:11.0 IDE interface: ALi Corporation M5229 IDE (rev c1) (prog-if fa)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
        ParErr+ Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
        >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 31
        Region 4: I/O ports at 10e0 [size=16]

So much so, that simple data transfers are corrupted - the very first
read from a disk to find the partition table in sector 0 is corrupted
and the machine fails to boot. I've debugged through this to verify
the problem, and for these machines for now I have built a custom
kernel with UDMA disabled altogether. It seems that the code in
ali15x3_can_ultra() is to blame:

static u8 ali15x3_can_ultra (ide_drive_t *drive)
{
#ifndef CONFIG_WDC_ALI15X3
        struct hd_driveid *id   = drive->id;
#endif /* CONFIG_WDC_ALI15X3 */

        return 0;

        if (m5229_revision <= 0x20) {
                return 0;
        } else if ((m5229_revision < 0xC2) &&
#ifndef CONFIG_WDC_ALI15X3
                   ((chip_is_1543c_e && strstr(id->model, "WDC ")) ||
                    (drive->media!=ide_disk))) {
#else /* CONFIG_WDC_ALI15X3 */
                   (drive->media!=ide_disk)) {
#endif /* CONFIG_WDC_ALI15X3 */
                return 0;
        } else {
                return 1;
        }
}

Looking back at the equivalent code in 2.4.27 (the previous kernel
this machine ran), that's rather different:

static u8 ali15x3_can_ultra (ide_drive_t *drive)
{
#ifndef CONFIG_WDC_ALI15X3
        struct hd_driveid *id   = drive->id;
#endif /* CONFIG_WDC_ALI15X3 */

        if (m5229_revision < 0xC1) {    /* According to ALi */
                return 0;
        } else if ((m5229_revision < 0xC2) &&
#ifndef CONFIG_WDC_ALI15X3
                   ((chip_is_1543c_e && strstr(id->model, "WDC ")) ||
                    (drive->media!=ide_disk))) {
#else /* CONFIG_WDC_ALI15X3 */
                   (drive->media!=ide_disk)) {
#endif /* CONFIG_WDC_ALI15X3 */
                return 0;
        } else {
                return 1;
        }
}

So it would seem there has been a regression here - the assumption now
is that versions between 0x20 and 0xC1 can use UDMA fine unless there
is a WDC drive attached, but the old code wouldn't try UDMA at all on
chips older than rev C1.

In case it's relevant, I have a Samsung drive attached:

hda: SAMSUNG SP0411N, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 78242976 sectors (40060 MB) w/2048KiB Cache, CHS=16383/255/63, (U)DMA
hda: cache flushes supported
 hda: hda1 hda2

I have the machine out and ready to experiment with if any more
details are needed to help solve this problem.

-- 
Steve McIntyre, Cambridge, UK.                                steve@einval.com
"Every time you use Tcl, God kills a kitten." -- Malcolm Ray
