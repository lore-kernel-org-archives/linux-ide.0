From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return
 zeroes after TRIM
Date: Wed, 07 Jan 2015 23:05:03 -0500
Message-ID: <54AE01EF.8050106@ubuntu.com>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net> <20141204170611.GB2995@htj.dyndns.org> <yq14mtahmil.fsf@sermon.lab.mkp.net> <20141205145148.GI4080@htj.dyndns.org> <1418184578.2121.3.camel@HansenPartnership.com> <20141210142927.GA6294@htj.dyndns.org> <yq1oarbcj6f.fsf@sermon.lab.mkp.net> <20150105162830.GP15833@htj.dyndns.org> <yq1387n8nfv.fsf@sermon.lab.mkp.net> <20150107025455.GL3077@htj.dyndns.org> <20150107041537.GH31508@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20150107041537.GH31508@dastard>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Tejun Heo <tj@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-ide@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 01/06/2015 11:15 PM, Dave Chinner wrote:
> (e.g. in ext4 inode tables because mkfs used to zero them) if they 
> haven't been used, so when it reads them it detects that 
> initialisation is needed because the blocks are empty....

No, it knows that the inode table needs initialized because there is a
flag in the group descriptor that says this inode table is still
uninitalized.  It never reads the blocks to see if they are full of
zeros.  mke2fs sets the flag when it does not initialize the table
with zeros, either by direct writes ( which it doesn't do if
lazy_itable_init is true, which it defaults to these days ), or by
discarding the blocks when the device claims to support deterministic
discard that zeros.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJUrgHvAAoJENRVrw2cjl5RWUUH/076fhOAYW8vRB285cz+UwrE
L7o3uteYa9OctoWZTctWAVueuISJaNsxzmbu04btznETkR/YbkkexpmXRKvYt6RZ
rlCzRLWLTOC4h57jZteczn9pBf0RBeeizU0pEdTdZP/IVxOqA6NDG1qywDCE9A+I
3frFg54alaZ4MCGH0jmPVbVxM6jY3/UhA8DnOoMSlIOXatV1X7UMPK3lMJ4Ih/Yx
e3yDWJjNHjAn88TRAGD6WJ2066t7DBGnLOOF9PscaZNW6f4hbuvEG9teAPk51OfS
cwypcLsk6Mj7WU8cSQ0T/6a7Qx84g9JC6wLR0QZCUCSau6ZfWf3ZuSI26i/Xlfc=
=BRqd
-----END PGP SIGNATURE-----
